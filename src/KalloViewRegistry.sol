// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * @title KalloViewRegistry
 * @notice A contract for posting, commenting, upvoting, and downvoting location-based reviews.
 */
contract KalloViewRegistry {
    event ReviewPosted(bytes32 locationId, bytes32 reviewId, address author);
    event ReviewUpvoted(bytes32 locationId, bytes32 reviewId, address voter);
    event ReviewDownvoted(bytes32 locationId, bytes32 reviewId, address voter);
    event ReviewCommented(bytes32 locationId, bytes32 reviewId, bytes32 commentId, address author);

    error AlreadyVoted();
    error AlreadyReviewed();

    // Mapping to track if an address has voted on a review
    mapping(bytes32 reviewId => mapping(address voter => bool voted)) _voted;

    // Mapping to store  by location and author
    mapping(bytes32 reviewHash => bool reviewed) _reviews;

    /**
     * @notice Post a review for a location.
     * @param locationId The unique identifier of the location.
     * @param reviewId The unique identifier of the review (IPFS URL).
     */
    function postReview(bytes32 locationId, bytes32 reviewId) external {
        bytes32 reviewHash = keccak256(abi.encodePacked(locationId, msg.sender));

        if (_reviews[reviewHash]) {
            revert AlreadyReviewed();
        }

        _reviews[reviewHash] = true;

        emit ReviewPosted(locationId, reviewId, msg.sender);
    }

    /**
     * @notice Comment on a review.
     * @param locationId The unique identifier of the location.
     * @param reviewId The unique identifier of the review (IPFS URL).
     * @param commentId The unique identifier of the comment (IPFS URL).
     */
    function commentReview(bytes32 locationId, bytes32 reviewId, bytes32 commentId) external {
        // There is no limit on comments
        // So we don't have any validations
        emit ReviewCommented(locationId, reviewId, commentId, msg.sender);
    }

    /**
     * @notice Upvote a review.
     * @param locationId The unique identifier of the location.
     * @param reviewId The unique identifier of the review (IPFS URL).
     */
    function upvoteReview(bytes32 locationId, bytes32 reviewId) external {
        // require that the user didn't already upvote or downvote
        _assureUserHasNotVoted(reviewId, msg.sender);

        emit ReviewUpvoted(locationId, reviewId, msg.sender);
    }

    /**
     * @notice Downvote a review.
     * @param locationId The unique identifier of the location.
     * @param reviewId The unique identifier of the review (IPFS URL).
     */
    function downvoteReview(bytes32 locationId, bytes32 reviewId) external {
        // require that the user didn't already upvote or downvote
        _assureUserHasNotVoted(reviewId, msg.sender);

        emit ReviewDownvoted(locationId, reviewId, msg.sender);
    }

    function _assureUserHasNotVoted(bytes32 reviewId, address voter) internal {
        if (_voted[reviewId][voter]) {
            revert AlreadyVoted();
        }
        _voted[reviewId][voter] = true;
    }
}
