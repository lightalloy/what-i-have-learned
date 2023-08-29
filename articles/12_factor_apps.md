https://12factor.net/

-  a methodology for building software-as-a-service apps that:

- declarative formats for setup automation, to minimize time and cost for new developers joining the project;
- maximum portability
- for deployment on modern cloud platforms (avoiding system administration)
- development = production, enable CD
- scale up without significant changes to tooling, architecture, or development practices.

## 1. Codebase

One codebase, many deploys

## 2. Dependencies

Explicitly declare and isolate dependencies
Declares all dependencies, completely and exactly, via a dependency declaration manifest.

> For example, Bundler for Ruby offers the Gemfile manifest format for dependency declaration and bundle exec for dependency isolation.

Dependency declaration and isolation must always be used together.
Do not rely on the implicit existence of any system tools, use the tool => vendor into the app.

## 3. Config

Store config in the environment.

Strict separation of config from code.
Config varies across deploys, code doesn't.

Definition of “config” does not include internal application config, e.g `config/routes.rb`.

> A litmus test for whether an app has all config correctly factored out of the code is whether the codebase could be made open source at any moment, without compromising any credentials.

Storing in files not in the revision control: better than in code, but you can mistakenly check it in the revision control. Config can also be scattered over the codebase.

The twelve-factor app stores config in environment variables.

## 4. Backing Services

- any service the app consumes over the network

e.g. database, smtp service, etc

Treat backing services as attached resources
> The code for a twelve-factor app makes no distinction between local and third party services.

A deploy of a 12-factor app should be able to be replaced with a third-party service. E.g. local smtp service or local mysql database to cloud hosted.

Resources can be attached to and detached from deploys at will.

## 5. Build, release, run

Strictly separate build and run stages

Build: convert code to an executable bundle known as build. the build stage fetches vendors dependencies and compiles binaries and assets.
Release stage:  takes the build produced by the build stage and combines it with the deploy’s current config.
Run stage: runs the app in the execution environment, by launching some set of the app’s processes against a selected release.

it is impossible to make changes to the code at runtime
Every release should always have a unique release ID

> Builds are initiated by the app’s developers whenever new code is deployed. Runtime execution, by contrast, can happen automatically in cases such as a server reboot, or a crashed process being restarted by the process manager.

## 6. Execute the app as one or more stateless processes

> Twelve-factor processes are stateless and share-nothing. Any data that needs to persist must be stored in a stateful backing service, typically a database.

The twelve-factor app never assumes that anything cached in memory or on disk will be available on a future request or job.

A twelve-factor app prefers to do assets compiling during the build stage.
Sticky sessions are a violation of twelve-factor and should never be used or relied upon.

## 7. Port binding

The web app exports HTTP as a service by binding to a port, and listening to requests coming in on that port.
Еhe port-binding approach means that one app can become the backing service for another app, by providing the URL to the backing app as a resource handle in the config for the consuming app.

12-factor app exposes its services by listening on a port.

## 8. Concurrency

Scale out via the process model.

Cues from the unix process model for running service daemons.

Assign each type of work to a process type (http requests - by a web process, background tasks - by a worker process)

12-factor app processes should never daemonize or write pid files. Instead rely on the OS system manager (systemd, foreman in development)

## 9. Disposability

Maximize robustness with fast startup and graceful shutdown

Processes should strive to minimize startup time.
Processes shut down gracefully when they receive a SIGTERM signal from the process manager.

http-requests - short or in case of long polling client attempts to reconnect.

For a worker process: shutdown => return current work into the queue. Wrap in a transaction or make idempotent.

Processes should also be robust against sudden death, in the case of a failure in the underlying hardware.

## 10. Dev/Prod Parity

Keep the gap between dev and prod small, designed for continious deployment.

Small time gap: deploy small and often.
Small personell gap: developers are involved in deployment.
Small tools gap: keep dev and prod as similar as possible.

It's tempting to use smth lightweight in dev and heavier in prod - e.g. sqlite/postgresql.
That's a violation of 12-factor.

## 11. Logs as Event Streams

> A twelve-factor app never concerns itself with routing or storage of its output stream.

A 12-factor app doesn't write or manage logfiles, each running process writes its event stream to `stdout`.
dev - view in terminal.

Stage and prod - captured by the execution environment, collated with other streams, routed to final destination for viewing and long-term archival.

Use oss log routers, e.g. logplex or fluentd.

## 12. Admin Processes

Run admin/management tasks as one-off processes.

One-off tasks: migrations, running arbitrary code in a console
> One-off admin processes should be run in an identical environment as the regular long-running processes of the app.

Run against a release using the same codebase and config.



