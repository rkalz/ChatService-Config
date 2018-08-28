## ChatService API Documentation

# Public Frontend API
REST APIs used by the client and thus exposed to users
* GET /
    * Login page
    * URL Response Parameters
        * err - Error code
            * fish - Internal Server Error
            * turkey - Incorrect password
            * mongoose - Account creation failed
            * viper - Account creation successful
* GET /chats
    * Main menu
    * TODO: Make sure user is logged in to give access (URL params)
* POST /signin
    * Performs authentication
    * TODO: Also perform session generation
    * JSON Input
        * user - Username
        * pass - Password
    * Response
        * fish error if the auth server has some error
        * turkey error if incorrect credentials
        * Redirect to /chats on success
* POST /signup
    * Creates an account
    * JSON input
        * user - Username
        * pass - Password
    * Response
        * fish error if auth server has some error
        * mongoose error if the account can't be created (taken username)
        * viper error on successful account creation (TODO: Add a different parameter for non-errors?)

# Authentication Server
Internal authentication server. Should be accessed only through internal load balancer.
* GET /
    * Used for testing to make sure the server is alive
* POST /api/v1/private/auth/signin
    * Signs in a user
    * JSON input
        * user - Username
        * pass - Password
    * Response - Mix of JSON and HTTP codes
        * HTTP Codes
            * Internal Server Error - Can't connect to a service, unexpected errors in logic
            * Bad Request - Failed to parse request
        * JSON
            * Code - Custom code
                * 100 - Sign in success
                * 101 - Sign in fail
                * 300 - Failed to read a HTTP body
                * 301 - Failed to marshal a HTTP body
            * SessionKey - optional, session ID
                * TODO: Should perform on frontend instead, will return UUID in future
* POST /api/v1/private/auth/signup
    * Creates an account
    * JSON input
        * user - Username
        * pass - Password
    * Response - Mix of JSON and HTTP codes
        * HTTP Codes
            * Internal Server Error - Can't connect to a service, unexpected errors in logic
            * Bad Request - Failed to parse request
        * JSON
            * Code - Custom code
                * 200 - Sign up success
                * 201 - Sign up failed
                * 300 - Failed to read a HTTP body
                * 301 - Failed to marshal a HTTP body
* POST /api/v1/private/auth/signout
    * Signs a user out
    * TODO: All this does is talk to the session server, may remove
    * JSON input
        * origin - user-agent, used by session server
        * user - UUID for user signing out
        * session - Session ID being terminated
    * JSON response - Mix of JSON and HTTP codes
        * HTTP Codes
            * Internal Server Error - Can't connect to a service, unexpected errors in logic
            * Bad Request - Failed to parse request
        * JSON
            * Code - Custom code
                * 200 - Sign up success
                * 201 - Sign up failed
                * 300 - Failed to read a HTTP body
                * 301 - Failed to marshal a HTTP body

# Sessions Server
Used to handle sessions, currently based on User-Agent
* GET /
    * Used for testing to make sure the server is alive
* POST /api/v1/private/sessions/check
    * Checks if a session exists
    * JSON input
        * uuid - UUID of a user
        * origin - User-Agent of a session
        * session - the ID of a session
    * JSON response
        * code - Custom code
            * 100 - Session was found and is good
            * 101 - Multiple sessions were found (unused)
            * 102 - No sessions were found (unused)
            * 103 - Session was found but it's outdated (unused)
            * 104 - Session get error
* POST /api/v1/private/sessions/add
    * Creates a new session
    * JSON input
        * uuid - UUID of a user
    * JSON response
        * code - Custom code
            * 200 - Session creation success
            * 201 - Session creation error
        * session - the session ID
* POST /api/v1/private/sessions/del
    * Deletes a session (logout)
    * JSON input
        * uuid - UUID of a user
        * origin - User-Agent of a session
        * session - the ID of a session
    * JSON response
        * code - Custom code
            * 300 - Successfully deleted session
            * 301 - Session deletion error
