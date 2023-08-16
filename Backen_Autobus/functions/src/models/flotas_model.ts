/* Modelo representa el concepto de flota */
/*============ Flota ============*/
export interface Flota {
    idFlota? :string,
    nom_coperativa :string,
    descripcion :string,
    imagen: string,
    
}

export function Flota(data :any, id?:string){
    const { nom_coperativa, descripcion, imagen } = data;

    let object :Flota = { 
        idFlota: id,                
        nom_coperativa :nom_coperativa,
        descripcion: descripcion,
        imagen: imagen
    };
    return object;
}