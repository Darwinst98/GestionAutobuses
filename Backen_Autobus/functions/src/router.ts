import {Application} from 'express';
import { registro } from './controllers/autentication_controller';

export function routes(app:Application) {
    
    app.post('/registro', registro);
}