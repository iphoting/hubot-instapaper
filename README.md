# hubot-instapaper

Adds an URL to the Instapaper Service.

See [`src/instapaper.coffee`](src/instapaper.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-instapaper --save`

Then add **hubot-instapaper** to your `external-scripts.json`:

```json
[
  "hubot-instapaper"
]
```

## Sample Interaction

```
user1>> hubot instapaper add https://github.com/hubot-scripts/hubot-instapaper/
hubot>> Title: iphoting/hubot-instapaper, URL: https://github.com/hubot-scripts/hubot-instapaper/, added.
```
