

import {MongoClient,Db} from "mongodb";


let mongoDb : Db


export async function connectToDatabase(){
    const  url = 'mongodb://127.0.0.1:27017'
    const  client = new MongoClient(url);
    mongoDb = client.db("notedb")
    console.log("mongodb connected successfully")
}

export function getDatabase() : Db{
    return mongoDb
}