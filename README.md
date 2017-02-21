# Sonar - Homeflow tech test submission

## Brief

Create a one page app to to search and display property data from an external API

## Local Setup

1. Clone the repo
2. Navigate to the folder created
3. Sign up for a Zoopla API key here (http://http://developer.zoopla.com/)
4. Export the key using the following (replacing the square brackets with your API key):

```
export ZOOPLA_API_KEY="[your API key here]"
```
5. Run the app:

```
ruby lib/app.rb
```

## Testing

Tested using RSPec and Capybara. To run tests, execute the following from the root of the project:

```
rspec
```

## Notes on the build

1. Elephant in the room: I didn't use the Homeflow API. It wasn't clear to me how to make specific queries (directly through the browser or using the gem). I was wasting time, and so made the decision to use another provider.
2. Prioritised the code and overall functionality over UX, but tried to keep this in mind throughout.
3. I wanted to use Ruby given the time constraints and so the natural choice for an API-consumer was Sinatra.
