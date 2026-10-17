#' App-engagement A/B experiment
#'
#' A two-factor experiment comparing a standard vs. redesigned app UI across
#' user cohorts, measuring engagement, consistency, and error rate. Useful
#' for teaching factorial experimental design (UI version x cohort).
#'
#' \itemize{
#'   \item engagement_score. Overall engagement score.
#'   \item consistency_index. Session-to-session consistency index.
#'   \item error_rate_pct. Percent of sessions containing a user error.
#'   \item sex. F or M (demographic covariate).
#'   \item ui_version. standard or redesigned.
#'   \item cohort. User cohort identifier.
#'   \item test_batch. Which of two testing batches the observation belongs to.
#' }
#'
#' @docType data
#'
#' @usage app_engagement_experiment
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::mice_weights} values (data provided by
#'   Karen Svenson, Jackson Laboratories), relabeled and multiplied by a
#'   fixed per-column factor (\code{engagement_score}, \code{consistency_index}:
#'   k = 2; \code{error_rate_pct}: k = 1.3; see REFLAVORING_PLAN.md ground
#'   rule 3).
#'
#' @note These are not real app-usage or engagement data. They are the
#'   original \code{dslabs::mice_weights} values, relabeled, with
#'   \code{engagement_score} and \code{consistency_index} multiplied by
#'   k = 2 and \code{error_rate_pct} by k = 1.3 so none of the three
#'   matches the dslabs original (see REFLAVORING_PLAN.md ground rule 3).
#'   A synthetic or real, ethically-sourced replacement is planned for a
#'   future release (see \code{BDS_development_plan.md} Phase 2).
#'
#' @details
#' \strong{Study design:} a fully between-subjects design. Each of the 780
#' rows is a different user, measured once: there are no repeated measures,
#' and no participant ID column, because one row is one user (in the
#' \code{dslabs::mice_weights} source, each row is a different mouse).
#' \code{ui_version} is a between-subjects factor (each user saw only one
#' version: 386 redesigned, 394 standard), fully crossed with \code{cohort}
#' (5 levels) and \code{sex}, with every combination present and roughly
#' balanced. \code{test_batch} is not balanced across UI versions
#' (redesigned 196/190, standard 246/148): treat it as a nuisance or blocking
#' variable, not a designed factor. \code{consistency_index} summarises each
#' user's sessions into a single value, so it is still one value per user.
#' Groups are therefore independent: compare them with methods for
#' independent samples (e.g. Welch's t-test, between-subjects ANOVA), not
#' paired or repeated-measures methods.
#'
#' **Teaching connection:** the two-factor design (UI version x cohort)
#' directly mirrors a UX A/B experiment testing two interface variants
#' across two user groups (e.g. interface version x expertise level). The
#' interaction term is crucial: an interface change that helps one cohort
#' may slow down another. This is the same two-way ANOVA logic used to
#' analyse UI-version x user-group study data.
#'
#' @examples
#' app_engagement_experiment |> head()
#' with(app_engagement_experiment, table(sex, ui_version))
#'
#' # Is the effect of UI version on engagement the same across sexes?
#' # (interaction term = "does the redesign help one group more than the other")
#' fit <- aov(engagement_score ~ ui_version * sex, data = app_engagement_experiment)
#' summary(fit)
#'
#' library(ggplot2)
#' ggplot(app_engagement_experiment, aes(x = ui_version, y = error_rate_pct, fill = sex)) +
#'   geom_violin() + geom_jitter(width = 0.1, alpha = 0.3) +
#'   labs(title = "Interaction plot: UI version x user group")
"app_engagement_experiment"
