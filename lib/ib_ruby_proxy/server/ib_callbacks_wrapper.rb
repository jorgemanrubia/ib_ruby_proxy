java_import 'com.ib.client.EWrapper'

# Let's mame more generic with EWrapper.java_class.declared_instance_methods
module IbRubyProxy
  module Server
    class IbCallbacksWrapper
      # include DRb::DRbObservable
      include EWrapper

      attr_reader :signal, :client

      def initialize
        @signal = EJavaSignal.new
        @client = EClientSocket.new(self, @signal)
      end

      def tickPrice(tickerId, field, price, attribs)
      end

      def tickSize(tickerId, field, size)
      end

      def tickOptionComputation(tickerId, field,
                                impliedVol, delta, optPrice,
                                pvDividend, gamma, vega, theta,
                                undPrice)
      end

      def tickGeneric(tickerId, tickType, value)

      end

      def tickString(tickerId, tickType, value)

      end


      def tickEFP(tickerId, tickType, basisPoints,
                  formattedBasisPoints, impliedFuture, holdDays,
                  futureLastTradeDate, dividendImpact,
                  dividendsToLastTradeDate)
      end

      def orderStatus(orderId, status, filled,
                      remaining, avgFillPrice, permId, parentId,
                      lastFillPrice, clientId, whyHeld, mktCapPrice)
      end

      def openOrder(orderId, contract, order,
                    orderState)
      end

      def openOrderEnd()

      end

      def updateAccountValue(key, value, currency,
                             accountName)
      end

      def updatePortfolio(contract, position,
                          marketPrice, marketValue, averageCost,
                          unrealizedPNL, realizedPNL, accountName)
      end

      def updateAccountTime(timeStamp)
      end

      def accountDownloadEnd(accountName)

      end

      def nextValidId(orderId)

      end

      def contractDetails(reqId, contractDetails)

      end

      def bondContractDetails(reqId, contractDetails)

      end

      def contractDetailsEnd(reqId)

      end

      def execDetails(reqId, contract, execution)

      end

      def execDetailsEnd(reqId)

      end

      def updateMktDepth(tickerId, position, operation,
                         side, price, size)
      end

      def updateMktDepthL2(tickerId, position,
                           marketMaker, operation, side, price, size, isSmartDepth)
      end

      def updateNewsBulletin(msgId, msgType, message,
                             origExchange)
      end

      def managedAccounts(accountsList)
      end

      def receiveFA(faDataType, xml)
      end

      def historicalData(reqId, bar)
      end

      def historicalDataEnd(reqId, startDateStr, endDateStr)
      end

      def scannerParameters(xml)
      end

      def scannerData(reqId, rank,
                      contractDetails, distance, benchmark,
                      projection, legsStr)
      end

      def scannerDataEnd(reqId)
      end


      def realtimeBar(reqId, time, open, high, low, close, volume, wap, count)
      end


      def currentTime(time)
      end


      def fundamentalData(reqId, data)
      end


      def deltaNeutralValidation(reqId, deltaNeutralContract)
      end


      def tickSnapshotEnd(reqId)
      end


      def marketDataType(reqId, marketDataType)
      end


      def commissionReport(commissionReport)
      end


      def position(account, contract, pos,
                   avgCost)
      end


      def positionEnd()
      end


      def accountSummary(reqId, account, tag,
                         value, currency)
      end


      def accountSummaryEnd(reqId)
      end


      def verifyMessageAPI(apiData)
      end


      def verifyCompleted(isSuccessful, errorText)
      end

      def verifyAndAuthMessageAPI(apiData, xyzChallenge)
      end


      def verifyAndAuthCompleted(isSuccessful, errorText)
      end

      def displayGroupList(reqId, groups)
      end


      def displayGroupUpdated(reqId, contractInfo)
      end


      # def error(e)
      # end
      #
      #
      # def error(str)
      # end


      def error(*args)
        puts args.inspect
      end


      def connectionClosed()
      end


      def connectAck()
      end


      def positionMulti(reqId, account, modelCode,
                        contract, pos, avgCost)
      end


      def positionMultiEnd(reqId)
      end


      def accountUpdateMulti(reqId, account, modelCode,
                             key, value, currency)
      end


      def accountUpdateMultiEnd(reqId)
      end


      def securityDefinitionOptionalParameter(reqId, exchange,
                                              underlyingConId, tradingClass, multiplier,
                                              expirations, strikes)
      end


      def securityDefinitionOptionalParameterEnd(reqId)
      end

      def softDollarTiers(reqId, tiers)
      end

      def familyCodes(familyCodes)
      end


      def symbolSamples(reqId, contractDescriptions)
      end


      def mktDepthExchanges(depthMktDataDescriptions)
      end


      def tickNews(tickerId, timeStamp, providerCode, articleId, headline, extraData)
      end


      def smartComponents(reqId, theMap)
      end


      def tickReqParams(tickerId, minTick, bboExchange, snapshotPermissions)
      end


      def newsProviders(newsProviders)
      end

      def newsArticle(requestId, articleType, articleText)
      end

      def historicalNews(requestId, time, providerCode, articleId, headline)

      end

      def historicalNewsEnd(requestId, hasMore)
      end

      def headTimestamp(reqId, headTimestamp)
      end

      def histogramData(reqId, items)
      end

      def historicalDataUpdate(reqId, bar)
      end

      def rerouteMktDataReq(reqId, conId, exchange)
      end

      def rerouteMktDepthReq(reqId, conId, exchange)
      end

      def marketRule(marketRuleId, priceIncrements)
      end

      def pnl(reqId, dailyPnL, unrealizedPnL, realizedPnL)
      end

      def pnlSingle(reqId, pos, dailyPnL, unrealizedPnL, realizedPnL, value)
      end

      def historicalTicks(reqId, ticks, done)
      end

      def historicalTicksBidAsk(reqId, ticks, done)
      end

      def historicalTicksLast(reqId, ticks, done)
        puts "Receiving: #{ticks.first}"
      end

      def tickByTickAllLast(reqId, tickType, time, price, size, tickAttribLast,
                            exchange, specialConditions)
      end

      def tickByTickBidAsk(reqId, time, bidPrice, askPrice, bidSize, askSize,
                           tickAttribBidAsk)
      end

      def tickByTickMidPoint(reqId, time, midPoint)
      end


      def orderBound(orderId, apiClientId, apiOrderId)
      end
    end

  end
end
