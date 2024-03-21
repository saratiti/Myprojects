// const passport = require('passport');
// const JwtStrategy = require('passport-jwt').Strategy;
// const ExtractJwt = require('passport-jwt').ExtractJwt;
// require('dotenv').config(); // Add this line to load environment variables

// const opts = {
//   jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
//   secretOrKey: process.env.JWT_SECRET,
// };

// passport.use(new JwtStrategy(opts, (jwt_payload, done) => {
//   // You might want to fetch the user from the database using the ID from jwt_payload
//   const user = { id: jwt_payload.sub, /* additional user properties */ };

//   if (user) {
//     return done(null, user);
//   } else {
//     return done(null, false);
//   }
// }));

// module.exports = passport;
