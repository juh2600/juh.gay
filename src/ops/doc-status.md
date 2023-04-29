% Document status policies
% juh
% 2023-04-10

[![General disclaimer](https://img.shields.io/badge/disclaimer-general-brightgreen.svg)](/advice/disclaimers.md#general)

[![Document status: Draft](https://img.shields.io/badge/status-draft-red.svg)](/ops/doc-status.md#draft)

<details>
<summary>Review log</summary>
</details>

---

# Document status badge definitions {#definitions}

Every document under `/ops/` MUST bear exactly one of these badges:

![Document status: Draft](https://img.shields.io/badge/status-draft-red.svg) {#draft}
~  `draft` status indicates that a document is still in its creation phase, has not been reviewed for correctness, and may be (is probably) incomplete. These documents SHOULD NOT be executed (except for testing) and MUST NOT be referenced as sources of truth.

![Document status: Review](https://img.shields.io/badge/status-review-yellow.svg) {#review}
~  `review` status indicates that the author thinks the document may be complete, but it needs further review (possibly by a third party) to ensure correctness. These documents SHOULD NOT be executed and SHOULD NOT be referenced as sources of truth.

![Document status: Approved](https://img.shields.io/badge/status-approved-brightgreen.svg) {#approved}
~  `approved` status means that this document is believed to be complete and correct and has passed any reviews that the author deemed necessary. These documents MUST be treated as sources of truth for operations at in-scope facilities (namely, juh's bedroom lab). If you are a third-party reader intending to use these documents, you SHOULD NOT treat these as sources of truth, and SHOULD conduct additional review of all information you wish to use. Please review the various [disclaimers](/advice/disclaimers.md).

![Document status: Deprecated](https://img.shields.io/badge/status-deprecated-darkorange.svg) {#deprecated}
~  `deprecated` means that this document is planned for obsoletion, but MAY still be executed and treated as a source of truth, until and unless it is superseded by a document with the `approved` status, at which point the deprecated document SHOULD NOT be executed or treated as a source of truth. Documents with this status SHOULD be annotated with an explanation of why they are deprecated, any obsoletion timelines and any superseding documents available.

![Document status: Obsolete](https://img.shields.io/badge/status-obsolete-darkred.svg) {#obsolete}
~  `obsolete` means that the document is no longer canonical. These documents MUST NOT be executed or treated as sources of truth. These documents MAY be annotated with an explanation of why they are deprecated, and SHOULD link to any documents that supersede them.

Every document tagged `approved`, `deprecated`, or `obsolete` MUST additionally bear a `freshness` badge indicating the last date that it was reviewed and reaffirmed in its entirety. This may not be the same as the last date that the document was changed, if the document was changed without reviewing the whole thing.

Every document that has completed a full review MUST bear a `<details>` code block containing a full history of all reviews that have been completed for that document, including the handle of the reviewer and the date of the review's completion. This history MUST be sorted chronologically, with the most recent review listed first.

# Review procedure {#procedure}

When a document is moved from `draft` to `review`, the author MUST [open an issue] on this site's GitHub repository. TODO complete this section

# State machine {#flow}

TODO describe which states can move to which (e.g. clarify a doc can go straight from draft to obsolete)

# Document header format {#format}

All dates must be written in ISO 8601 format: YYYY-MM-DD.

TODO complete this section

```
% Title
% Author
% Date of most recent edit

[![General disclaimer](https://img.shields.io/badge/disclaimer-general-brightgreen.svg)](/advice/disclaimers.md#general)
[![Hazmat disclaimer](https://img.shields.io/badge/disclaimer-hazmat-red.svg)](/advice/disclaimers.md#hazmat)

[![Document status: Approved](https://img.shields.io/badge/status-approved-brightgreen.svg)](/ops/doc-status.md#approved)

<details>
<summary>Review log</summary>
</details>

---

; content begins down here
```