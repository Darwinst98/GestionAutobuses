import {Application} from 'express';
import { registro } from './controllers/autentication_controller';
import { listFlotas, createFlota, editFlota, deleteFlota } from './controllers/flotas_controller';
import { createRuta, deleteRuta, editRuta, listRutas } from './controllers/rutas_controller';
import { createHorario, deleteHorario, editHorario, listHorarios } from './controllers/horios_controller';

export function routes(app:Application) {

    app.get('/flota', listFlotas);
    app.post('/flota', createFlota);
    app.put('/flota/:id', editFlota);
    app.delete('/flota/:id', deleteFlota);

    app.get('/ruta', listRutas); 
    app.post('/ruta', createRuta);
    app.put('/ruta/:id', editRuta);
    app.delete('/ruta/:id', deleteRuta);

    app.get('/horario', listHorarios);
    app.post('/horario', createHorario);
    app.put('/horario/:id', editHorario);
    app.delete('/horario/:id', deleteHorario);
    
    app.post('/registro', registro);
}