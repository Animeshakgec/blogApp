const express = require("express");
// const mongoose=require('mongoose');
const app = express()
const port =process.env.PORT || 8000

// main().catch(err => console.log(err));

// async function main() {
//   await mongoose.connect('mongodb://localhost:27017/myapp');
  
//   // use `await mongoose.connect('mongodb://user:password@localhost:27017/test');` if your database has auth enabled
// }
const Mongoose = require("mongoose")
const localDB = "mongodb://localhost:27017/myblog3db";
const connectDB = async () => {
  await Mongoose.connect(localDB, {
    useNewUrlParser: true,
    // useCreateIndex:true,
    useUnifiedTopology: true,
  })
  console.log("MongoDB Connected")
}
connectDB();
app.use("/uploads",express.static("uploads"));
app.use(express.json())
const userroute=require("./routes/user");
app.use("/user",userroute);
const profile=require("./routes/profile");
app.use("/profile",profile)
const blog=require("./routes/blogger");
app.use("/blogs",blog)
// process.on("unhandledRejection", err => {
//     console.log(`An error occurred: ${err.message}`)
//     server.close(() => process.exit(1))
// // })
app.route("/").get((req,res)=>{
  res.end("hello word")
})
app.listen(port, () => console.log(`Server Connected to port ${port}`))