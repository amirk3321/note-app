
import express from "express";
import {getDatabase} from "../config/mongodb_client";
import { User } from "../models/user_model";
import bcrypt from 'bcrypt';
import {ObjectId} from "mongodb";


export class  UserController {



    static async signUp(request : express.Request,response :express.Response){


        let db = getDatabase();

        let usersCollection = db.collection("users")

        const user : User=request.body;


        const checkUserInDb = {
            email :user.email
        }

        const data =await usersCollection.find(checkUserInDb).toArray();


        if (data.length != 0){

            response.status(403).send({
                "status":"Failure",
                "response":"Email Already Exists"
            })

        }else{

            const slat = await bcrypt.genSalt(10)
            user.password= await  bcrypt.hash(user.password,slat)

           const responseData =await usersCollection.insertOne(user);

            const objectId = responseData.insertedId;

           const userInfo =await usersCollection.find({_id:new ObjectId(objectId)}).toArray()


            const userResponseData = userInfo[0];

           userResponseData.password  = "";

           response.status(200).send({
               "status":"success",
               "response": userResponseData,
           })

        }


    }

    static async  signIn(request : express.Request , response : express.Response){


        let db = getDatabase();

        let usersCollection = db.collection("users")

        const user : User=request.body;


        const checkUserInDb = {
            email :user.email
        }

        const data =await usersCollection.find(checkUserInDb).toArray();

        if (data.length !=0){

            let userInfo = data[0];

            const pass =await  bcrypt.compare(user.password,userInfo.password)


            if ((user.email == userInfo.email) && pass){

                userInfo.password = "";

                response.status(200).json({
                    "status":"success",
                    "response":userInfo
                })


            }    else{

                response.status(403).json({
                    "status":"Failure",
                    "response":"Invalid Email & Password please check"
                })

            }


        }else{
            response.status(403).json({
                "status":"Failure",
                "response":"Invalid Email & Password please check"
            })
        }

    }


    static  async  myProfile(request: express.Request,response :express.Response) {
        let db = getDatabase();

        let usersCollection = db.collection("users")

        const uid = request.query.uid;

        const userData =await usersCollection.find({_id:new ObjectId(uid!.toString())}).toArray();

        response.status(200).json(
            {
                "status":"success",
                "response":userData[0]
            }
        )

    }


    static async  updateProfile(request : express.Request , response : express.Response){


        let db = getDatabase();

        let usersCollection = db.collection("users")

        const user : User=request.body;

        const updateUserObject ={
            username : user.username,
        }

       const updateUserInfo= await  usersCollection.updateOne({_id: new  ObjectId(user.uid)},{$set : updateUserObject})

        response.status(200).json({
            "status":"success",
            "response":updateUserInfo
        })


    }
}