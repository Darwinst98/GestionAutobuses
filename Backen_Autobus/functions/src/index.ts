import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';  
import * as express from 'express';
import * as cors from 'cors';
import { routes } from './router';

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
db.settings({ignoreUndefinedProperties : true, timestampsInSnapshot: true});

//=================== Servidor EXPRESS =====================//
const server = express();
server.use(cors({origin: true}));

//=================== RUTAS =====================//
routes(server);

//=================== Exportacion del Servidor =====================//
export { db };
export const api = functions.https.onRequest(server);
