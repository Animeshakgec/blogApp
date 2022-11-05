const mongoose=require("mongoose");
const profile= new mongoose.Schema(
    {
        username:{
            type:String,
            required:true,
            unique:true,
        },
        name:String,
        profession:String,
        dob:String,
        titleline:String,
        about:String,
        img:{
            type:String,
            default:" ",
        }
    },
    {
        timestamp:true,
    }
);
module.exports=mongoose.model("profile",profile)