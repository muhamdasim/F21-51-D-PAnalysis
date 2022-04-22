class FlaskAppWrapper(object):

    def __init__(self, app,  domain_url, **configs):
        self.app = app
        self.configs(**configs)
        self.domain_url = domain_url

    
    def getDomainUrl(self):
        return self.domain_url

    def configs(self, **configs):
        for config, value in configs:
            self.app.config[config.upper()] = value

    def add_endpoint(self, endpoint=None, endpoint_name=None, handler=None, methods=['GET'], *args, **kwargs):
        self.app.add_url_rule(endpoint, endpoint_name, handler, methods=methods, *args, **kwargs)

    def run(self, **kwargs):
        self.app.run(**kwargs)