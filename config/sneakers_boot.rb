require_relative './boot'
require 'sneakers/handlers/maxretry'

Sneakers.configure({
  workers: 2, # number of processes
  handler: Sneakers::Handlers::Maxretry,

  retry_timeout: 5000,       # Milliseconds between job retry
  retry_max_times: 0,
  timeout_job_after: 180,    # Maximal seconds to wait for job
  prefetch: 5,               # Grab 10 jobs together. Better speed.
  threads: 3,                # Threadpool size (good to match prefetch)
  env: ENV['HANAMI_ENV'],    # Environment
  durable: false,            # Is queue durable?
  ack: true,                 # Must we acknowledge?
  heartbeat: :server,        # Keep a good connection with broker
  exchange: 'sneakers',      # AMQP exchange
  start_worker_delay: 10     # Delay between thread startup
})

Sneakers::ContentType.register(
  content_type: 'application/json',
  serializer:   ->(payload) { JSON.generate(payload) },
  deserializer: ->(payload) { JSON.parse(payload) }
)

Sneakers.logger.level = Logger::INFO
