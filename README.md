# docker-ipfs
Run ipfs on host from inside docker container

<!-- 
dc run --entrypoint /bin/bash --rm ipfs

    # command:
    #   - "/bin/sh"
    #   - -ecx
    #   - |
    #     uname -a && \
    #     mkdir -p ${HOME}/.asperitus && \
    #     rm -rf ${HOME}/.asperitus/ipfs && \
    #     docker cp ipfs:/dist/$$(uname -s) ${HOME}/.asperitus/ipfs && \
    #     ${HOME}/.asperitus/ipfs/rc.sh
 -->
