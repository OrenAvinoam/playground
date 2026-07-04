{{/*
Labels applied to every resource this chart renders.
*/}}
{{- define "playground.labels" -}}
app.kubernetes.io/part-of: playground
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}
