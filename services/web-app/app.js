const express = require('express');
const session = require('express-session');
const Keycloak = require('keycloak-connect');
const path = require('path');

const app = express();
const memoryStore = new session.MemoryStore();

app.use(session({
  secret: 'super-secret-key',
  resave: false,
  saveUninitialized: true,
  store: memoryStore
}));

// Set trust proxy so Express honors X-Forwarded-Proto
app.set('trust proxy', true);

const keycloak = new Keycloak({ store: memoryStore });

app.use(keycloak.middleware());

// Public route
app.get('/', (req, res) => {
  res.send('<h1>Welcome to SSO Demo</h1><a href="/app/secure">Go to Secure Page</a>');
});

// Protected route
app.get('/app/secure', keycloak.protect(), (req, res) => {
  res.send('<h2>This is a secure page. Authenticated via Keycloak!</h2>');
});

// Start server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`App running on port ${PORT}`);
});
