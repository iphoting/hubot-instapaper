# Description:
#   instapaper - Adds URLs to Instapaper Service.
#
# Configuration:
#    HUBOT_INSTAPAPER_USERNAME
#    HUBOT_INSTAPAPER_PASSWORD
#
# Commands:
#   hubot instapaper add <URL> - Add URL to Instapaper Account.
#
# Author:
#   iphoting
#

module.exports = (robot) ->
  api_endpoint = 'https://www.instapaper.com/api/add'
  auth = 'Basic ' + new Buffer("#{process.env.HUBOT_INSTAPAPER_USERNAME}:#{process.env.HUBOT_INSTAPAPER_PASSWORD}").toString('base64')

  robot.respond /instapaper add (https?:\/\/[\/\w\.\-%#]+\/?)/i, id: 'instapaper.private', (res) ->
    data = "url=#{encodeURIComponent(res.match[1])}"
    robot.logger.debug "Instapaper: Payload: #{data}"

    res.http(api_endpoint).headers("Authorization": auth, "Content-Length": data.length, "Accept": "application/json")
      .post(data) (err, resp, body) ->
        if err || resp.statusCode != 201
          msg = err || switch resp.statusCode
            when 400
              "Bad request or exceeded the rate limit"
            when 403
              "Invalid username or password"
            when 500
              "The service encountered an error"

          res.reply "Backend encountered an error: #{msg}. Please try again later."
        else
          id = JSON.parse(body).bookmark_id
          robot.logger.debug "Instapaper: ID: #{id}, added."

          h = resp.headers
          res.reply "Title: #{h['x-instapaper-title']}, URL: #{h['content-location']}, added."
