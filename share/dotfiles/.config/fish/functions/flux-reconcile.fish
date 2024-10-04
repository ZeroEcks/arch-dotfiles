function flux-reconcile
    flux reconcile source git $argv[1]; and flux reconcile kustomization $argv[1]
end
