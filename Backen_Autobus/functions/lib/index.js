"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.api = exports.db = void 0;
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require("express");
const cors = require("cors");
const router_1 = require("./router");
//=================== Firebase Credenciales =====================//
const firebaseConfigs = {
    apiKey: "AIzaSyDJlraDBdCtcpWYEmj-yXCc00Gh0xiGJCk",
    authDomain: "app-autobus.firebaseapp.com",
    projectId: "app-autobus",
    storageBucket: "app-autobus.appspot.com",
    messagingSenderId: "150562334294",
    appId: "1:150562334294:web:d82cc1cd8e3b9b3997bdf7"
};
admin.initializeApp(firebaseConfigs);
//=================== Firebase Base de Datos =====================//
const db = admin.firestore(); //Base de datos de collections & documents
exports.db = db;
db.settings({ ignoreUndefinedProperties: true, timestampsInSnapshot: true });
//=================== Servidor EXPRESS =====================//
const server = express();
server.use(cors({ origin: true }));
//=================== RUTAS =====================//
(0, router_1.routes)(server);
exports.api = functions.https.onRequest(server);
//# sourceMappingURL=index.js.map