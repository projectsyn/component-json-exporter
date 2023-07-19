local kap = import 'lib/kapitan.libjsonnet';
local prometheus = import 'lib/prometheus.libsonnet';
local inv = kap.inventory();
local params = inv.parameters.json_exporter;

local labels =
  if std.member(inv.applications, 'prometheus') then
    prometheus.RegisterNamespace({}).metadata.labels
;

{
  values: params.helm_values {
    serviceMonitor+: {
      defaults+: {
        labels+: labels,
      },
    },
    prometheusRule+: {
      additionalLabels+: labels,
    },
  },
}
