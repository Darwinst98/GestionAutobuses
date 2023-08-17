import { Request, Response } from "express";
import { db } from "../index";
import { Ruta } from "../models/rutas_model";
import { Respuesta } from "../models/respuesta";

export async function listRutas(req: Request, res: Response) {       
    try {        
        let snapshot = await db.collection("rutas").get();
        return res.status(200).json(snapshot.docs.map(doc => Ruta(doc.data(), doc.id)));                 
    } catch (err) {
        return handleError(res, err);
    }       
};

export async function createRuta(req: Request, res: Response) {           
    try {                    
        const newRuta = Ruta(req.body);
        const RutaAdded = await db.collection("rutas").add(newRuta);                            
        return res.status(201).json(Respuesta('Ruta agregada', `La Ruta fue agregada correctamente con el id ${RutaAdded.id}`, newRuta, 201));
    } catch (err) {
        return handleError(res, err);
    }
}

export async function editRuta(req: Request, res: Response) {           
    try {
        const RutaId = req.params.id;
        const updatedData = req.body;
        
        const RutaRef = db.collection("rutas").doc(RutaId);
        await RutaRef.update(updatedData);
        
        return res.status(200).json(Respuesta('Ruta actualizada', `La Ruta con id ${RutaId} fue actualizada`, updatedData, 200));
    } catch (err) {
        return handleError(res, err);
    }
}

export async function deleteRuta(req: Request, res: Response) {           
    try {
        const RutaId = req.params.id;
        const RutaDelete = await db.collection("rutas").doc(RutaId).delete();
        
        return res.status(200).json(Respuesta('Ruta eliminada', `La Ruta con id ${RutaId} fue eliminada`, RutaDelete, 200));
    } catch (err) {
        return handleError(res, err);
    }
}

function handleError(res: Response, err: any) {
    return res.status(500).send({ message: `${err.code} - ${err.message}` });
}
