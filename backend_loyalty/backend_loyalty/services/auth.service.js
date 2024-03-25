const UserModel = require('../models/user');
const cacheUtil = require('../utils/cache');

exports.createUser = (user) => {
    return UserModel.create(user);
}

exports.findUserByusername = (username) => {
    return UserModel.findOne({
        where: {
            username: username
        }
    })
}
exports.findUserById = (id) => {
    return UserModel.findByPk(id, {
      attributes: ['username', 'email', 'profile_picture'],
    });
  };



exports.logoutUser = (token, exp) => {
    const now = new Date();
    const expire = new Date(exp * 1000);
    const milliseconds = expire.getTime() - now.getTime();
    /* ----------------------------- BlackList Token ---------------------------- */
    return cacheUtil.set(token, token, milliseconds);
}