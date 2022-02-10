process sourmash_download_db {
  if (workflow.profile.contains('gcloud')) {publishDir 'gs://gcloud_storage/databases-nextflow/sourmash', mode: 'copy', pattern: "genbank-k31.lca.json.gz" }
  else { storeDir 'nextflow-autodownload-databases/sourmash' }  
  //this condition is here only for gcloud usage 
  errorStrategy = { task.exitStatus==14 ? 'retry' : 'terminate' }
  maxRetries = 5
  label 'ubuntu' 
  output:
  path("genbank-k31.lca.json.gz")
  script:
  """
  #wget https://ndownloader.figshare.com/files/18809423?private_link=ed98a281ef089c033352 -O gtdb.lca.json
  wget --no-check-certificate https://osf.io/4f8n3/download -O genbank-k31.lca.json.gz 
  """
}

    // The link use from osf.io require sourmash V3 (sourmash V3.3.0 is working))