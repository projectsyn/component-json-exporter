local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
local params = inv.parameters.json_exporter;
local argocd = import 'lib/argocd.libjsonnet';

local app = argocd.App('json-exporter', params.namespace);

local appPath =
  local project = std.get(std.get(app, 'spec', {}), 'project', 'syn');
  if project == 'syn' then 'apps' else 'apps-%s' % project;

{
  ['%s/json-exporter' % appPath]: app,
}
