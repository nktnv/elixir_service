class CoincapPrices
  include Sneakers::Worker

  QUEUE_NAME = 'exs.coincap_prices'

  from_queue QUEUE_NAME

  def work(msg)
    Hanami.logger.info("ACKNOWLAGED #{QUEUE_NAME}")
    ack!
  end
end
