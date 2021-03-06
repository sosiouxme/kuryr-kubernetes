FROM rhel7:latest

ENV container=oci

RUN yum update -y \
 && yum clean all \
 && rm -rf /var/cache/yum

RUN yum install -y python-pbr python-devel

RUN bash tools/build-rpm.sh
# TODO: Install the RPM's
USER kuryr
CMD ["--config-dir", "/etc/kuryr"]
ENTRYPOINT [ "/usr/bin/kuryr-k8s-controller" ]

LABEL \
        io.k8s.description="This is a component of OpenShift Container Platform and provides a kuryr-controller service." \
        maintainer="Michal Dulko <mdulko@redhat.com>" \
        name="openshift/kuryr-controller" \
        io.k8s.display-name="kuryr-controller" \
        version="4.0.0" \
        com.redhat.component="kuryr-controller-container"
