const express = require('express');
const session = require('express-session');
const Keycloak = require('keycloak-connect');

const app = express();
const memoryStore = new session.MemoryStore();

app.use(session({
  secret: 'super-secret-key',
  resave: false,
  saveUninitialized: true,
  store: memoryStore
}));

const keycloak = new Keycloak({ store: memoryStore });

app.use(keycloak.middleware());

app.get('/', (req, res) => {
  res.send('<h1>Welcome to Single Sign-On by Keycloak</h1><a href="/secure">Go to Secure Page</a>');
});

app.get('/secure', keycloak.protect(), (req, res) => {
  res.send('<h2>This is a secure page. Authenticated via Keycloak!</h2>');
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`App running on http://localhost:${PORT}`);
});
