local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
local params = inv.parameters.json_exporter;
local argocd = import 'lib/argocd.libjsonnet';

local app = argocd.App('json-exporter', params.namespace);

{
  'json-exporter': app,
}
