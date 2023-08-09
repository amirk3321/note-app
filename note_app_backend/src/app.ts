import express from 'express';
import cors from 'cors'
import {connectToDatabase} from "./config/mongodb_client"
import appLogger from "./middleware/app_logger"
import userRouter from "./router/user_router";
import noteRouter from "./router/note_router";

const app : express.Application = express();

const hostName = "localhost";
const portNumber = 5001;

app.use(cors())
app.use(express.json())
app.use(appLogger)
app.use(express.urlencoded({extended:false}))
app.use("/v1/user",userRouter)
app.use("/v1/note",noteRouter)





app.listen(portNumber,hostName,async ()=>{
    await connectToDatabase();
    console.log("Welcome to Note App backed Service ")
})
