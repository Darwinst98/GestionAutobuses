"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.isAuthorized = exports.isAuthenticated = void 0;
const admin = require("firebase-admin");
const respuesta_1 = require("./models/respuesta");
async function isAuthenticated(req, res, next) {
    const { authorization } = req.headers;
    if (!authorization)
        return res.status(401).send((0, respuesta_1.Respuesta)('No autorizado', 'Usuario sin autorización', { authorization }, 401));
    if (!authorization.startsWith('Bearer'))
        return res.status(401).send((0, respuesta_1.Respuesta)('No autorizado', 'Usuario sin autorizacion válida', { authorization }, 401));
    const split = authorization.split('Bearer ');
    if (split.length !== 2)
        return res.status(401).send((0, respuesta_1.Respuesta)('No autorizado', 'Usuario sin autorizacion válida', { authorization }, 401));
    const token = split[1];
    try {
        const decodedToken = await admin.auth().verifyIdToken(token);
        console.log("decodedToken", JSON.stringify(decodedToken));
        res.locals = Object.assign(Object.assign({}, res.locals), { uid: decodedToken.uid, role: decodedToken.role, email: decodedToken.email });
        return next();
    }
    catch (err) {
        return res.status(401).send((0, respuesta_1.Respuesta)('Error al autenticar', 'Error al autenticar el usuario', { err }, 401));
    }
}
exports.isAuthenticated = isAuthenticated;
function isAuthorized(opts) {
    return (req, res, next) => {
        const { role } = res.locals;
        if (!role)
            return res.status(403).send((0, respuesta_1.Respuesta)('No autorizado', 'Usuario con el rol no autorizado', { role }, 403));
        if (opts.hasRole.includes(role))
            return next();
        return res.status(403).send((0, respuesta_1.Respuesta)('No autorizado', 'Usuario con el rol no autorizado', { role }, 403));
    };
}
exports.isAuthorized = isAuthorized;
//# sourceMappingURL=midleware.js.map