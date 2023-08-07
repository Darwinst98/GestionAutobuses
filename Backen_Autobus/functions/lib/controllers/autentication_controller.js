"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.registro = void 0;
const admin = require("firebase-admin");
const respuesta_1 = require("../models/respuesta");
async function registro(req, res) {
    try {
        const { email, password, role } = req.body;
        const userId = await admin.auth().getUserByEmail(email);
        if (userId != null) {
            return res.status(400).json((0, respuesta_1.Respuesta)('El usuario ya esta registrado', `Usuario ${email}`, userId, 400));
        }
        const user = await admin.auth().createUser({
            email,
            password
        });
        await admin.auth().setCustomUserClaims(user.uid, { role });
        return res.status(201).json((0, respuesta_1.Respuesta)('Usuario creado', `Usuario ${user.displayName} creado y rol ${role}`, user, 201));
    }
    catch (err) {
        return handleError(res, err);
    }
}
exports.registro = registro;
function handleError(res, err) {
    return res.status(500).send({ message: `${err.code} - ${err.message}` });
}
//# sourceMappingURL=autentication_controller.js.map