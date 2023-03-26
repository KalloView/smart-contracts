// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/KalloViewRegistry.sol";

contract KalloViewRegistryTest is Test {
    KalloViewRegistry public registry;

    event ReviewPosted(bytes32 locationId, bytes32 reviewId, address author);
    event ReviewUpvoted(bytes32 locationId, bytes32 reviewId, address voter);
    event ReviewDownvoted(bytes32 locationId, bytes32 reviewId, address voter);
    event ReviewCommented(bytes32 locationId, bytes32 reviewId, bytes32 commentId, address author);

    function setUp() public {
        registry = new KalloViewRegistry();
    }

    function testPostReview(bytes32 locationId, bytes32 reviewId) public {
        vm.assume(locationId != bytes32(0));
        vm.assume(reviewId != bytes32(0));
        vm.assume(locationId != reviewId);

        vm.expectEmit(true, true, true, true);
        emit ReviewPosted(locationId, reviewId, address(this));
        registry.postReview(locationId, reviewId);
    }

    function testUpvote(bytes32 locationId, bytes32 reviewId) public {
        vm.assume(locationId != bytes32(0));
        vm.assume(reviewId != bytes32(0));
        vm.assume(locationId != reviewId);

        vm.expectEmit(true, true, true, true);
        emit ReviewUpvoted(locationId, reviewId, address(this));
        registry.upvoteReview(locationId, reviewId);
    }

    function testDownvote(bytes32 locationId, bytes32 reviewId) public {
        vm.assume(locationId != bytes32(0));
        vm.assume(reviewId != bytes32(0));
        vm.assume(locationId != reviewId);

        vm.expectEmit(true, true, true, true);
        emit ReviewDownvoted(locationId, reviewId, address(this));
        registry.downvoteReview(locationId, reviewId);
    }

    function testComment(bytes32 locationId, bytes32 reviewId, bytes32 commentId) public {
        vm.assume(locationId != bytes32(0));
        vm.assume(reviewId != bytes32(0));
        vm.assume(commentId != bytes32(0));
        vm.assume(locationId != reviewId);
        vm.assume(locationId != reviewId);
        vm.assume(commentId != locationId);

        vm.expectEmit(true, true, true, true);
        emit ReviewCommented(locationId, reviewId, commentId, address(this));
        registry.commentReview(locationId, reviewId, commentId);
    }
}
