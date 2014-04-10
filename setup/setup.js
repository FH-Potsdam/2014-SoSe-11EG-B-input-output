var GitHubApi = require("github");

github.authenticate({
  type: "basic",
  username: username,
  password: password
});