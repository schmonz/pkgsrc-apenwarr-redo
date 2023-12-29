# $NetBSD: Makefile,v 1.13 2023/10/23 06:37:37 wiz Exp $

DISTNAME=	redo-0.42d
PKGNAME=	apenwarr-${DISTNAME}
PKGREVISION=	3
CATEGORIES=	devel
MASTER_SITES=	${MASTER_SITE_GITHUB:=apenwarr/}
GITHUB_PROJECT=	redo
GITHUB_TAG=	${DISTNAME}

MAINTAINER=	schmonz@NetBSD.org
HOMEPAGE=	https://github.com/apenwarr/redo/
COMMENT=	Python implementation of DJB's redo build tool
LICENSE=	apache-2.0

TOOL_DEPENDS+=	${PYPKGPREFIX}-beautifulsoup4-[0-9]*:../../www/py-beautifulsoup4
TOOL_DEPENDS+=	${PYPKGPREFIX}-markdown-[0-9]*:../../textproc/py-markdown
DEPENDS+=	dash-[0-9]*:../../shells/dash
DEPENDS+=	${PYPKGPREFIX}-setproctitle-[0-9]*:../../sysutils/py-setproctitle

WRKSRC=		${WRKDIR}/redo-${DISTNAME}

PYTHON_VERSIONS_INCOMPATIBLE=	27

SUBST_CLASSES+=		paths
SUBST_STAGE.paths=	do-configure
SUBST_FILES.paths=	redo/whichpython.do
SUBST_VARS.paths=	PYTHONBIN

INSTALL_ENV+=	MANDIR=${DESTDIR}${PREFIX}/${PKGMANDIR}

post-install:
	cd ${DESTDIR}${PREFIX}/bin; \
	for i in *; do mv -f $${i} apenwarr-$${i}; done
	cd ${DESTDIR}${PREFIX}/${PKGMANDIR}/man1; \
	for i in *; do mv -f $${i} apenwarr-$${i}; done

.include "../../lang/python/batteries-included.mk"
.include "../../lang/python/application.mk"
.include "../../lang/python/extension.mk"
.include "../../mk/bsd.pkg.mk"
