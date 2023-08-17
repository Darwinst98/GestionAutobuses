/* Modelo representa el concepto de Ruta */
/*============ Ruta ============*/
export interface Ruta {
    idRuta? :string,
    ruta :string,
    idFlota :string,
    imagen: string,
    
}

export function Ruta(data :any, id?:string){
    const { ruta, idFlota, imagen } = data;

    let object :Ruta = { 
        idRuta: id,                
        ruta :ruta,
        idFlota: idFlota,
        imagen: imagen
    };
    return object;
}