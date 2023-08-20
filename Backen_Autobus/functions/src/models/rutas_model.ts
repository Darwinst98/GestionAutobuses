/* Modelo representa el concepto de Ruta */
/*============ Ruta ============*/
export interface Ruta {
    idRuta? :string,
    ruta :string,
    idFlota :string,
    imagen: string,
    destino: string,
    imagenDestino: string
    
}

export function Ruta(data :any, id?:string){
    const { ruta, idFlota, imagen, destino, imagenDestino } = data;

    let object :Ruta = { 
        idRuta: id,                
        ruta :ruta,
        idFlota: idFlota,
        imagen: imagen,
        destino: destino,
        imagenDestino: imagenDestino
    };
    return object;
}