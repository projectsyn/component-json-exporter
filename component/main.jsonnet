// main template for json-exporter
local kap = import 'lib/kapitan.libjsonnet';
local kube = import 'lib/kube.libjsonnet';
local prometheus = import 'lib/prometheus.libsonnet';
local inv = kap.inventory();
// The hiera parameters for the component
local params = inv.parameters.json_exporter;

local ns_metadata = {
  metadata+: {
    labels+: {
      SYNMonitoring: 'main',
      'app.kubernetes.io/part-of': 'argocd',
      'openshift.io/cluster-monitoring': 'true',
    },
  },
};

local namespace =
  if std.member(inv.applications, 'prometheus') then
    prometheus.RegisterNamespace(kube.Namespace(params.namespace)) + ns_metadata
  else
    kube.Namespace(params.namespace) + ns_metadata
;

{
  '00_namespace': namespace,
}
