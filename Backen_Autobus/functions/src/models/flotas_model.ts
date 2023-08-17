/* Modelo representa el concepto de flota */
/*============ Flota ============*/
export interface Flota {
    idFlota? :string,
    nomCoperativa :string,
    descripcion :string,
    imagen: string,
    
}

export function Flota(data :any, id?:string){
    const { nomCoperativa, descripcion, imagen } = data;

    let object :Flota = { 
        idFlota: id,                
        nomCoperativa :nomCoperativa,
        descripcion: descripcion,
        imagen: imagen
    };
    return object;
}