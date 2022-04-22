const { ethers } = require('hardhat');
const { use, expect } = require('chai');
const { solidity } = require('ethereum-waffle');
const { utils } = require('ethers');

use(solidity);

describe('Voting', function () {
	it('it should create and fetch contestants', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		await voting.createContestant('Nkemjika Obi');
		await voting.createContestant('Ebube Okoli');

		const contestants = await voting.getContestants();

		expect(contestants.length).to.equal(2);
		let [k, m] = contestants.map(contestant => contestant.name);

		expect(k).to.equal('Nkemjika Obi');
		expect(m).to.equal('Ebube Okoli');
	});
	it('it should fetch users', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		const users = await voting.getUsers();

		expect(users.length).to.equal(1);
	});
	it('it should fetch votes', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		const votes = await voting.fetchVotes();

		expect(votes.length).to.equal(0);
	});
	it('it should create users', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		await voting.createUser('0x2223241f7d197cca53c1B13df8CfA38264017F04', 1);

		const users = await voting.getUsers();

		expect(users.length).to.equal(2);
	});
	it('it should change user type', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		await voting.createUser('0x2223241f7d197cca53c1B13df8CfA38264017F04', 2);

		const user = await voting.changeUserType(2, 2);

		const users = await voting.getUsers();

		let [k, m] = users.map(user => user.userType);

		expect(m).to.equal('Student');
	});
	it('it should enable vote', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		await voting.enableVote();
		const isEnabled = await voting.isVotingEnabled();
		expect(isEnabled).to.equal(true);
	});
	it('it should disable vote', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		await voting.disbaleVote();
		const isDisabled = await voting.isVotingEnabled();
		expect(isDisabled).to.equal(false);
	});
	it('it should show votes', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		await voting.showVotesVisibility(1);
		const isVisible = await voting.isVotingVisible();
		expect(isVisible).to.equal(true);
	});
	it('it should hide votes', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		await voting.hideVotesVisibility(1);
		const isVisible = await voting.isVotingVisible();
		expect(isVisible).to.equal(false);
	});
	it('it should enable contract', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		await voting.enableContract();
		const isDisabled = await voting.contractDisabled();
		expect(isDisabled).to.equal(false);
	});
	it('it should disable contract', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		await voting.disableContract();
		const isDisabled = await voting.contractDisabled();
		expect(isDisabled).to.equal(true);
	});
	it('it should vote', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		await voting.createContestant('Nkemjika Obi');

		await voting.vote(1, 1);

		const votes = await voting.fetchVotes();
		expect(votes.length).to.equal(1);
	});
	it('is a valid user', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		await voting.createUser('0x2223241f7d197cca53c1B13df8CfA38264017F04', 1);

		const res = await voting.isValidUser(
			'0x2223241f7d197cca53c1B13df8CfA38264017F04'
		);
		expect(res).to.equal(true);
	});
	it('check if chairman', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		const users = await voting.getUsers();
		let [k, m] = users.map(user => user.userAddress);

		const res = await voting.checkIfChairman(k);

		expect(res).to.equal(true);
	});
	it('collate results', async () => {
		const Voting = await hre.ethers.getContractFactory('Voting');
		const voting = await Voting.deploy();

		await voting.deployed();

		await voting.collateResults(0);
		const res = await voting.isVotingEnded();

		expect(res).to.equal(true);
	});
});
