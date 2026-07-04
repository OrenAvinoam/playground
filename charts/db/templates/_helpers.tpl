{{/*
Expand the name of the chart.
*/}}
{{- define "db.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We won't actually use this for the Deployment/Service's own metadata.name
(those stay hardcoded as "db" — see deployment.yaml), but it's kept here
because it's the standard third helper alongside .name/.chart, and other
charts that reference this one by release name would expect it to exist.
*/}}
{{- define "db.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "db.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels.
*/}}
{{- define "db.labels" -}}
helm.sh/chart: {{ include "db.chart" . }}
{{ include "db.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels — the stable subset used in matchLabels/selectors.
Kept separate from the full label set above because spec.selector on a
Deployment is immutable: if it included something that changes across
upgrades (like the chart version in "helm.sh/chart"), `helm upgrade` would
fail trying to change an immutable field.
*/}}
{{- define "db.selectorLabels" -}}
app.kubernetes.io/name: {{ include "db.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
