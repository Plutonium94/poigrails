package fr.mbds.tpgrails

import grails.gorm.DetachedCriteria
import groovy.transform.ToString

import org.apache.commons.lang.builder.HashCodeBuilder

@ToString(cache=true, includeNames=true, includePackage=false)
class UtilisateurRole implements Serializable {

	private static final long serialVersionUID = 1

	Utilisateur utilisateur
	Role role

	UtilisateurRole(Utilisateur u, Role r) {
		this()
		utilisateur = u
		role = r
	}

	@Override
	boolean equals(other) {
		if (!(other instanceof UtilisateurRole)) {
			return false
		}

		other.utilisateur?.id == utilisateur?.id && other.role?.id == role?.id
	}

	@Override
	int hashCode() {
		def builder = new HashCodeBuilder()
		if (utilisateur) builder.append(utilisateur.id)
		if (role) builder.append(role.id)
		builder.toHashCode()
	}

	static UtilisateurRole get(long utilisateurId, long roleId) {
		criteriaFor(utilisateurId, roleId).get()
	}

	static boolean exists(long utilisateurId, long roleId) {
		criteriaFor(utilisateurId, roleId).count()
	}

	private static DetachedCriteria criteriaFor(long utilisateurId, long roleId) {
		UtilisateurRole.where {
			utilisateur == Utilisateur.load(utilisateurId) &&
			role == Role.load(roleId)
		}
	}

	static UtilisateurRole create(Utilisateur utilisateur, Role role, boolean flush = false) {
		def instance = new UtilisateurRole(utilisateur: utilisateur, role: role)
		instance.save(flush: flush, insert: true)
		instance
	}

	static boolean remove(Utilisateur u, Role r, boolean flush = false) {
		if (u == null || r == null) return false

		int rowCount = UtilisateurRole.where { utilisateur == u && role == r }.deleteAll()

		if (flush) { UtilisateurRole.withSession { it.flush() } }

		rowCount
	}

	static void removeAll(Utilisateur u, boolean flush = false) {
		if (u == null) return

		UtilisateurRole.where { utilisateur == u }.deleteAll()

		if (flush) { UtilisateurRole.withSession { it.flush() } }
	}

	static void removeAll(Role r, boolean flush = false) {
		if (r == null) return

		UtilisateurRole.where { role == r }.deleteAll()

		if (flush) { UtilisateurRole.withSession { it.flush() } }
	}

	static constraints = {
		role validator: { Role r, UtilisateurRole ur ->
			if (ur.utilisateur == null || ur.utilisateur.id == null) return
			boolean existing = false
			UtilisateurRole.withNewSession {
				existing = UtilisateurRole.exists(ur.utilisateur.id, r.id)
			}
			if (existing) {
				return 'userRole.exists'
			}
		}
	}

	static mapping = {
		id composite: ['utilisateur', 'role']
		version false
	}
}
