import os

import tornado.ioloop
import tornado.web
import tornado.log
import boto3
from dotenv import load_dotenv

from jinja2 import \
  Environment, PackageLoader, select_autoescape

PORT = int(os.environ.get('PORT','8888'))
ENV = Environment(
  loader=PackageLoader('myapp', 'templates'),
  autoescape=select_autoescape(['html', 'xml'])
)


load_dotenv('.env')

SES_CLIENT = boto3.client(
  'ses',
  aws_access_key_id=os.environ.get('AWS_ACCESS_KEY'),
  aws_secret_access_key=os.environ.get('AWS_SECRET_KEY'),
  region_name="us-east-1"
)


class TemplateHandler(tornado.web.RequestHandler):
  def render_template (self, tpl, context):
    template = ENV.get_template(tpl)
    self.write(template.render(**context))

class MainHandler(TemplateHandler):
  def get(self):
    names = self.get_query_arguments('name')
    self.set_header(
      'Cache-Control',
      'no-store, no-cache, must-revalidate, max-age=0')
    self.render_template("index.html", {'names': names, 'amount': 42.55})

class PageHandler(TemplateHandler):
  def post(self, page):
        print('PageHandler post')
        name = self.get_body_argument('name')
        email = self.get_body_argument('mail')
        text = self.get_body_argument('comment')
        print(name, email, text)
        response = SES_CLIENT.send_email(
        Destination={
            'ToAddresses': ['mjspitzfaden@aol.com'],
        },
        Message={
            'Body': {
            'Text': {
                'Charset': 'UTF-8',
                'Data': text,
            },
            },
            'Subject': {'Charset': 'UTF-8', 'Data': 'Portfolio Contact'},
        },
        Source='mjspitzfaden@aol.com',
        )
        messages = 'Thank you, your email has been sent!'
        self.render_template('cform.html', {'messages': messages})

  def get(self, page):
    self.set_header(
      'Cache-Control',
      'no-store, no-cache, must-revalidate, max-age=0')
    self.render_template(page, {})


def make_app():
  return tornado.web.Application([
    (r"/", MainHandler),
    (r"/page/(.*)", PageHandler),
    (
      r"/static/(.*)",
      tornado.web.StaticFileHandler,
      {'path': 'static'}
    ),
  ], autoreload=True)

if __name__ == "__main__":
  tornado.log.enable_pretty_logging()

  app = make_app()
  app.listen(PORT, print('Server started on localhost:' + str(PORT)))
  tornado.ioloop.IOLoop.current().start()

# request = YouTooHandler(request_info)
# request.get()
