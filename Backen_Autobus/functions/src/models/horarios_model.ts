/* Modelo representa el concepto de Horario */
/*============ Horario ============*/
export interface Horario {
    idHorario? :string,
    hora :string,
    idFlota :string,
    idRuta :string,
    
}

export function Horario(data :any, id?:string){
    const { hora, idFlota, idRuta } = data;

    let object :Horario = { 
        idHorario: id,                
        hora :hora,
        idFlota :idFlota,
        idRuta :idRuta
    };
    return object;
}