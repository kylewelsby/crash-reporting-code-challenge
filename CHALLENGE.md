# Mini Crash Processor

We processes billions of events per day. In order to do this efficiently, We uses a queueing system in which newly received crashes are promptly added to a queue. Worker processes consume crashes from the queue, analyzing the crash data and ensuring the crash is persisted to various data stores.

We would like you to build a mini crash processor that queues crash reports in redis and processes them asynchronously. The application should be written in Ruby (with Rails if you like)

Spend around 2-3 hours on this challenge (just let us know how long you spent on it). 

## Crash Report Payload

A sample JSON crash report payload to use for this exercise is shown below along with the validation rules that apply to the payload.

```javascript
{
  projectId: "1234", // Mandatory
  severity: "error", // One of "error", "warning" or "info".
  message: "An error occurred", // Mandatory
  stacktrace: [
    {
      file: "Crash.java", // Mandatory
      method: "crashyMethod", // Mandatory
      line: 10 // Optional
    },
    {
      file: "Main.java",
      method: "main",
      line: 5
    }
  ],

  // Any custom metadata the user has provided.  The structure is undefined.  Optional
  metadata: {
    customField: "customValue",
    customEntity: {
      id: "123",
      description: "Sample metadata"
    }
  }
}
```

## Tasks
The exercise is split into multiple tasks. Try to get as many tasks done as you can in the time frame. If you are close to running out of time, add comments to the code explaining the approach you would take if you had more time and to sketch out the design a little. Also highlight any compromises you've made or any edge cases the code will not perform well in.

The submitted code should be as production-ready as it can be, given the time constraints.


### 1. Implement a basic crash processor

- Create a REST endpoint that receives a crash report JSON payload. The endpoint should:
  - Add the payload to a queue of some sort (redis is a good option here)
  - Respond to the REST request (so that the request doesn't have to wait for the crash to be processed)

- Create a consumer service that asynchronously processes the crash reports from the in-memory queue using a single thread. The service should:
  - Check whether the payload is valid (using the rules indicated in the payload example)
  - If the payload is invalid - Increment a counter of invalid payloads against the `projectId`
  - If the payload is valid - Increment a counter of crashes received for the crash severity against the `projectId`
  - Sleep for a random interval between `10ms` - `1000ms` (to simulate a slow down due to interacting with a database)

### 2. Add an endpoint for viewing crash statistics

- Add a single statistics REST endpoint that allows a user to see the statistics for a given `projectId`. The response should show:
  - The number of invalid payloads for the project
  - The number of valid error severity payloads for the project
  - The number of valid warning severity payloads for the project
  - The number of valid info severity payloads for the project

### 3. Allow custom crash statistics

- Modify the application to allow custom counters to be recorded and queried based on metadata values so that the following operations are possible via the REST API:
  - Count the instances of `metadata.subscription.level = "pro plan"` for `projectId` "100"
  - Count the instances of `metadata.query.stats.duration > 1000` for `projectId` "200"
- Return the custom counts as part of the statistics REST response

### 4. Add concurrency

- Modify the consumer service to enable concurrent crash report processing.

### 5. Avoid projects swarming the queue

- Implement a strategy to avoid a single project swarming the queue unfairly. The mechanism for fairness can be whatever you deem appropriate, but should have the effect of not allowing a single project to flood the queue so that another project has disrupted service.


## Guidelines

- Feel free to add any gems/dependencies you like.
- Please submit your solution, include any instructions necessary for running your solution.
- Err on the side of adding more comments than usual, explaining your rationale and any trade-offs considered along the way.
- If you abandon an early solution in favor of a better one, feel free to include the earlier version and leave a comment explaining the relative benefits of the newer version.
- If you get close to running out of time, add some comments to describe what you would do differently if you had more time.
- There's a lot here - certainly enough to spend more than 2-3 hours on - it's up to you to decide how you want to allocate the time you spend on this. For example, if you would prefer to do fewer of the tasks and optimize on overall quality, that's completely reasonable. Don't feel that the aim is to get through all of the tasks at any cost.
- The goal is to make appreciable progress through these tasks, while demonstrating a breadth of skills and consideration of architectural tradeoffs.