import mongoose from 'mongoose';
var Schema = mongoose.Schema;

// Each schema maps to a MongoDB collection and defines the shape of the documents within that collection.
var testSchema = new Schema({
    id: Number,
    title: String,
    time: String,
    date: String,
    location: String,
    descript: String,
    lat: Number,
    lng: Number 
});

var Test = mongoose.model('test', testSchema, 'test');

export default Test;