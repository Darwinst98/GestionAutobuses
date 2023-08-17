import { Request, Response } from "express";
import { db } from "../index";
import { Flota } from "../models/flotas_model";
import { Respuesta } from "../models/respuesta";

export async function listFlotas(req: Request, res: Response) {       
    try {        
        let snapshot = await db.collection("autobuses").get();
        return res.status(200).json(snapshot.docs.map(doc => Flota(doc.data(), doc.id)));                 
    } catch (err) {
        return handleError(res, err);
    }       
};

export async function createFlota(req: Request, res: Response) {           
    try {                    
        const newFlota = Flota(req.body);
        const flotaAdded = await db.collection("autobuses").add(newFlota);                            
        return res.status(201).json(Respuesta('Flota agregado', `La flota fue agregado correctamente con el id ${flotaAdded.id}`, newFlota, 201));
    } catch (err) {
        return handleError(res, err);
    }
}

export async function editFlota(req: Request, res: Response) {           
    try {
        const flotaId = req.params.id;
        const updatedData = req.body;
        
        const flotaRef = db.collection("autobuses").doc(flotaId);
        await flotaRef.update(updatedData);
        
        return res.status(200).json(Respuesta('Flota actualizada', `La flota con id ${flotaId} fue actualizada`, updatedData, 200));
    } catch (err) {
        return handleError(res, err);
    }
}

export async function deleteFlota(req: Request, res: Response) {           
    try {
        const flotaId = req.params.id;
        const flotaDelete = await db.collection("autobuses").doc(flotaId).delete();
        
        return res.status(200).json(Respuesta('Flota eliminada', `La flota con id ${flotaId} fue eliminada`, flotaDelete, 200));
    } catch (err) {
        return handleError(res, err);
    }
}

function handleError(res: Response, err: any) {
    return res.status(500).send({ message: `${err.code} - ${err.message}` });
}
