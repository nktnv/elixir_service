class BinanceTickers
  include Sneakers::Worker

  QUEUE_NAME = 'exs.binance_pairs_tickers'

  from_queue QUEUE_NAME

  def work(msg)
    puts msg
    Hanami.logger.info("ACKNOWLAGED #{QUEUE_NAME}")
    ack!
  end
end
