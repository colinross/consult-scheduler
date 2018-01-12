# Consult-Scheduler

Scenerio:
We just added the capability to have video conferencing as part of our platform's consultation
abilities, but the problem now is that we don't have a great way to organize when to have calls.

We really need some-type of scheduling functionally and one of the senior devs started
working on it but has now asked you to wrap up the work.

## Task: Implement a `create` endpoint
As an api-client, I need to be able to make a request to the platform to create a new 
`Appointment` record so that I can be scheduled for a video consultation.

### Acceptance Criteria:
  - Should not allow appointments to overlap
  - Should allow appointments to have a duration of (minutes): 15, 30, 45, or 60
  - Should allow passing in a range of time using both `start_date` and `end_date` attributes, respectively.
  - If a range is passed in, the system should schedule the appointment for the next available time that fits it.

### Technical Requirements:
  - Maintain the Appointment as a RESTful that uses the (JSON-API)[http://jsonapi.org/] spec for both requests and responses.
  - Use (ISO-8601)[https://en.wikipedia.org/wiki/ISO_8601] for Date/DateTime values in requests/response.

## Setup
Just run `bin/setup` from the repository root to get your environment set up

- Run `rake spec` to run the tests
- Run `rails server` to run a server

### Other Notes
Feel free to add comments to your own code (or ours) as you wish. This might also allow help communicate why you 
may decide to make certain choices.

Don't overthink it too much, we aren't looking for hours and hours of develoment work, just a small sample of code
in order to drive our in-house interview process.


