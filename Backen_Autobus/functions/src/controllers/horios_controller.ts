import { Request, Response } from "express";
import { db } from "../index";
import { Horario } from "../models/horarios_model";
import { Respuesta } from "../models/respuesta";

export async function listHorarios(req: Request, res: Response) {       
    try {        
        let snapshot = await db.collection("horarios").get();
        return res.status(200).json(snapshot.docs.map(doc => Horario(doc.data(), doc.id)));                 
    } catch (err) {
        return handleError(res, err);
    }       
};

export async function createHorario(req: Request, res: Response) {           
    try {                    
        const newHorario = Horario(req.body);
        const HorarioAdded = await db.collection("horarios").add(newHorario);                            
        return res.status(201).json(Respuesta('Horario agregada', `La Horario fue agregada correctamente con el id ${HorarioAdded.id}`, newHorario, 201));
    } catch (err) {
        return handleError(res, err);
    }
}

export async function editHorario(req: Request, res: Response) {           
    try {
        const HorarioId = req.params.id;
        const updatedData = req.body;
        
        const HorarioRef = db.collection("horarios").doc(HorarioId);
        await HorarioRef.update(updatedData);
        
        return res.status(200).json(Respuesta('Horario actualizada', `La Horario con id ${HorarioId} fue actualizada`, updatedData, 200));
    } catch (err) {
        return handleError(res, err);
    }
}

export async function deleteHorario(req: Request, res: Response) {           
    try {
        const HorarioId = req.params.id;
        const HorarioDelete = await db.collection("horarios").doc(HorarioId).delete();
        
        return res.status(200).json(Respuesta('Horario eliminado', `El Horario con id ${HorarioId} fue eliminado`, HorarioDelete, 200));
    } catch (err) {
        return handleError(res, err);
    }
}

function handleError(res: Response, err: any) {
    return res.status(500).send({ message: `${err.code} - ${err.message}` });
}
