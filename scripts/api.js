const express = require('express');
const router = express.Router();
const FabricService = require('./fabricService')

const fabricService = new FabricService();


router.post("/enrollAdmin", (req,res) => {
    fabricService.enrollAdmin().then((results) => {
        res.send(results);
        return results;
    });
});

router.post("/registerUser", (req,res) => {
    fabricService.registerUser().then((results) => {
        res.send(results);
        return results;
    });
});

router.post("/SetValue", (req,res) => {
    fabricService.SetData(req.body.key, req.body.value).then((results) => {
        res.send(results);
        return results;
    });
});

router.post("/GetHistory", (req,res) => {
    fabricService.GetHistory(req.body.key).then((results) => {
        res.send(results);
        return results;
    });
});

router.post("/GetValue", (req,res) => {
    fabricService.GetData(req.body.key).then((results) => {
        res.send(results);
        return results;
    });
});


module.exports = router;
