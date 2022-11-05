const express =require("express");
const router=express.Router();
const profile=require("../models/userprofile");
const middleware=require("./middleware");
const multer =require("multer");
const path=require("path");
const storage=multer.diskStorage({
    destination:(req,file,cb)=>{
        cb(null,"./uploads");
    },
    filename:(req,file,cb)=>{
        cb(null,req.decoded.username+".jpg");
    },
});
const filefilter=(req,file,cb)=>{
    if(file.mimetype=="image/jpeg" || file.mimetype=="image/png"){
        cb(null,true);
    }else{
        cb(null,false);
    }
};
const upload=multer({
    storage:storage,
    limits:{fieldSize:1024*1024*6},
    fileFilter:filefilter,
});

// const saved = await new profile({}).save();

router.route("/getdata").get(middleware.checkToken, async(req,res)=>{
    try {
        const data = await profile.findOne({username: req.decoded.username});
        if(!data){
            res.json({
                msg:"data is not found",
                data:[]
            })
        }
        else{
            res.json({
                message:"data is found",
                data:data,
            })
        }

    } catch(err) {
        res.json({err})
    }
    
    // await profile.findOne({username:req.decoded.username},(e,r)=>{
    //     if(e) return res.json({err:e});
    //     if(r==null) return res.json({data:[]});
    //     else return res.json({data:r})
    // })
})
router.route("/update").patch(middleware.checkToken, async(req,res)=>{
    let Profile={};
    try {
        const data = await profile.findOne({username: req.decoded.username});
        if(!data){
            Profile={};
        }
        else if(data){
            Profile=data;
        }
        const updatedata=await profile.findOneAndUpdate(
            {username: req.decoded.username},
            {$set:{
                name:req.body.name==null?Profile.name:req.body.name,
                profession:req.body.profession==null?Profile.profession:req.body.profession,
                dob:req.body.dob==null?Profile.dob:req.body.dob,
                titlename:req.body.titlename==null?Profile.titlename:req.body.titlename,
                about:req.body.about==null?Profile.about:req.body.about,
            }},
        );
        if(!updatedata){
            res.json({data:[]});
        }
        else if(data){
            res.json({data:updatedata})
        }
    } catch(err) {
        res.json({err})
    }
    
    // await profile.findOne({username:req.decoded.username},(e,r)=>{
    //     if(e) return res.json({err:e});
    //     if(r==null) return res.json({data:[]});
    //     else return res.json({data:r})
    // })
})

// router.route("/update").patch(middleware.checkToken,async(req,res)=>{
//     var Profile={}
//     await profile.findOne({username:req.decoded.username},(e,r)=>{
//         if(e) Profile={};
//         if(r!=null) Profile=r;
//     }),
//     const saved = await profile.findOne({username:req.decoded.username},
//     saved.name = 
        // $set:{
        //     name:req.body.name==null?Profile.name:req.body.name,
        //     profession:req.body.profession==null?Profile.profession:req.body.profession,
        //     dob:req.body.dob==null?Profile.dob:req.body.dob,
        //     titlename:req.body.titlename==null?Profile.titlename:req.body.titlename,
        //     about:req.body.about==null?Profile.about:req.body.about,
        // },
    //     Map.user<String,String>={
    //         name:req.body.name==null?Profile.name:req.body.name,
    //         profession:req.body.profession==null?Profile.profession:req.body.profession,
    //         dob:req.body.dob==null?Profile.dob:req.body.dob,
    //         titlename:req.body.titlename==null?Profile.titlename:req.body.titlename,
    //         about:req.body.about==null?Profile.about:req.body.about,
    //     },user.save(),
    // {new:true},(e,r)=>{
    //     if(e) return res.json({err:e});
    //     if(r==null) return res.json({data:[]});
    //     else return res.json({data:r})
    // }
    // try {
    //     var Profile={}
    //     const v = await profile.findOne({ username:req.decoded.username})
    //     if (!v) {
    //       Profile={}
    //     } if(v) {
    //       Profile=v
    //     }
    //     var l=await profile.findOneAndUpdate({username:req.decoded.username},{
    //         $set:{
    //             name:req.body.name==null?Profile.name:req.body.name,
    //             profession:req.body.profession==null?Profile.profession:req.body.profession,
    //             dob:req.body.dob==null?Profile.dob:req.body.dob,
    //             titlename:req.body.titlename==null?Profile.titlename:req.body.titlename,
    //             about:req.body.about==null?Profile.about:req.body.about,
    //         }
    //     }
    //     )
    //     if(!l) return res.json({err:e});
    //     if(l==null) return res.json({data:[]});
    //     else return res.json({data:r})


    //   } catch (error) {
    //     res.status(400).json({
    //       message: "An error occurred",
    //       error: error.message,
    //     })
    //   }
router.route("/add/image").patch(middleware.checkToken,upload.single("img"), async(req,res)=>{
    try {
        await profile.findOneAndUpdate(
            {username:req.decoded.username},
            {
                $set:{img:req.file.path}
            },
            {new:true},
            (err,result)=>{
                if (err){
                    return res.status(500).send(err);
                }
                const response={
                    message:"image added succesfully",
                    data:result,
                };
                return res.status(200).send(response);
            }
        )
    } catch(err) {
        console.log(err);
    }
})
router.route("/checkprofile").get(middleware.checkToken,(req,res)=>{
    profile.findOne({username:req.decoded.username},(err,result)=>{
        if(err) return res.json({
            err:err
        })
        else if (result ==null){
            return res.json({status:false,username:username});
        }
        else{
            return res.json({status:true});
        }
    })
})
router.route("/add").post(middleware.checkToken,(req,res)=>{
        var userk=profile({
        username:req.decoded.username,
        name:req.body.name,
        profession:req.body.profession,
        dob:req.body.dob,
        titlename:req.body.titlename,
        about:req.body.about,

    });
    userk.save()
    .then(()=>{
        return res.status(200).json({msg:"profile is completed"})
    })
    .catch((err)=>{
        return res.status(400).json({err:err})
    })
})
module.exports=router;